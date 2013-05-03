
//helpers
String.prototype.startsWith = function (prefix) {
    return (this.substr(0, prefix.length) === prefix);
};
String.prototype.endsWith = function (prefix) {
    return (this.substr(this.length - prefix.length - 1, prefix.length) === prefix);
};
String.prototype.has = function (c) {
    return this.indexOf(c) > -1;
};
String.prototype.trim = function (compare) {
    return this.replace(/^\s*/, "").replace(/\s*$/, "");
}
String.prototype.equals = function (compare) {
    return this.toLowerCase() == compare.toLowerCase();
}
String.prototype.multiReplace = function (replacestr, newstr) {
    var containerstr = this;
    for (ictr = 0; ictr < 2; ictr++) {
        if (containerstr.has(replacestr)) {
            ictr = 0;
            containerstr = containerstr.replace(replacestr, newstr);
        }
    }
    return containerstr;
}




define(["Boiler"], function (Boiler) {

    var FormBuilder = function () {

        var self = this;

        self.getScript = function (formItem) {
            switch (formItem) {

                case 'HeroBar':
                    return self.HeroBar_formjs();
                    break;

                case 'Ad':
                    return self.Ad_formjs();
                    break;

                case 'ContentArea':
                    return self.ContentArea_formjs();
                    break;

                case 'Notices':
                    return self.Notices_formjs();
                    break;

                case 'button':
                    return self.button_formjs();
                    break;

                case 'checkbox':
                    return self.checkbox_formjs();
                    break;

                case 'combobox':
                    return self.combobox_formjs();
                    break;

                case 'label':
                    return self.label_formjs();
                    break;

                case 'multiline-textbox':
                    return self.multiline_textbox_formjs();
                    break;

                case 'radiobutton':
                    return self.radiobutton_formjs();
                    break;

                case 'textbox':
                    return self.textbox_formjs();
                    break;

                case 'ranking':
                    return self.ranking_formjs();
                    break;

                case 'checkboxlist':
                    return self.checkboxlist_formjs();
                    break;

                case 'menu_component':
                    return self.menu_component_formjs();
                    break;

                case 'Three Columns Row':
                    return self.Three_Columns_Row_formjs();
                    break;
            }
        };

        self.getName = function (convertstr) {
            var returnstr = convertstr.multiReplace(' ', '_');
            return returnstr;
        };

        self.Three_Columns_Row_formjs = function () {
            $('#col1').blur(function () {
                $('.preview .col1').text($('#col1').val());
            });
            $('#col2').blur(function () {
                $('.preview .col2').text($('#col2').val());
            });
            $('#col3').blur(function () {
                $('.preview .col3').text($('#col3').val());
            });
        };

        self.HeroBar_formjs = function () {

            $('#Heading').blur(function () {
                $('.preview .Heading').text($('#Heading').val());
            });

            $('#Tagline').blur(function () {
                $('.preview .Tagline').text($('#Tagline').val());
            });

            $('#LearnMore').blur(function () {
                $('.preview .LearnMore').text($('#LearnMore').val());
            });

            $('#LearnMoreLink').blur(function () {
                $('.preview .LearnMore').attr('href', $('#LearnMoreLink').val());
            });
        };

        self.Ad_formjs = function () {
            $('#content').blur(function () {
                $('.preview .content').text($('#content').val());
            });
        };

        self.ContentArea_formjs = function () {
            $('#content').blur(function () {
                $('.preview .content').text($('#content').val());
            });

        };

        self.Notices_formjs = function () {
            $('#content').blur(function () {
                $('.preview .content').text($('#content').val());
            });

        };

        self.button_formjs = function () {
            $('#label').blur(function () {
                $('.preview input[type=button]').val($('#label').val());
            });

        };

        self.checkbox_formjs = function () {
            $('#QuestionText').blur(function () {
                $('.preview .label').text($('#QuestionText').val());
            });
            $('#value').blur(function () {
                $('.preview input[type=checkbox]').val($('#value').val());
                $('.preview .value').text($('#value').val());
            });
            $('#name').blur(function () {

                $('.preview input[type=checkbox]').attr('id', $('#name').val());
                $('.preview input[type=checkbox]').attr('name', $('#name').val());

            });

        };

        //combobox_formjs needs internet search to see how to add items to select.
        self.combobox_formjs = function () {

            $('#name').blur(function () {
                var name = self.getName($('#name').val());
                $('.preview select').attr('id', name);
                $('.preview select').attr('name', name);
            });

            $('#questionText').blur(function () {
                $('.preview .questionText').text($('#questionText').val());
            });

            $('#addOption').click(
                function (e) {
                    e.preventDefault();
                    var newoption = "<option value='" + self.getName($('#value').val()) + "'>" + $('#text').val() + "</option>";
                    alert(newoption);
                    $('.preview .questionSelect').children.add(newoption);
                }
            );

        };

        self.label_formjs = function () {
            $('#label').blur(function () {
                $('.preview .label').text($('#label').val());
            });

        };

        self.multiline_textbox_formjs = function () {
            $('#label').blur(function () {
                $('.preview .label').text($('#label').val());
            });
            $('#name').blur(function () {
                var name = self.getName($('#name').val());
                $('.preview textarea').attr('id', name);
                $('.preview textarea').attr('name', name);
            });
        };

        self.radiobutton_formjs = function () {
            $('#QuestionText').blur(function () {
                $('.preview .label').text($('#QuestionText').val());
            });
            $('#value').blur(function () {
                $('.preview input[type=radio]').val(self.getName($('#value').val()));
                $('.preview .value').text($('#value').val());
            });
            $('#name').blur(function () {
                var name = self.getName($('#name').val());
                $('.preview input[type=radio]').attr('id', name);
                $('.preview input[type=radio]').attr('name', name);
            });
        };

        self.textbox_formjs = function () {
            $('#label').blur(function () {
                $('.preview .label').text($('#label').val());
            });
            $('#name').blur(function () {
                var name = self.getName($('#name').val());
                $('.preview input[type=text]').attr('id', name);
                $('.preview input[type=text]').attr('name', name);

            });
        }
;
        self.ranking_formjs = function () {
            $('#QuestionText').blur(function () {
                $('.preview .label').text($('#QuestionText').val());
            });
            $('#Choices').blur(function () {
                var choices = $('#Choices').val().split('\n');
                var htmlline = "<tr><th>Items</th>";
                for (var ii = 0; ii < choices.length; ii++) {
                    htmlline = htmlline + "<th>" + choices[ii] + "</th>";
                }
                htmlline = htmlline + "</tr>";
                $('.preview thead').html(htmlline);
            });
            $('#Items').blur(function () {
                var items = $('#Items').val().split('\n');
                var choices = $('#Choices').val().split('\n');
                var htmlline = "";
                for (var ii = 0; ii < items.length; ii++) {
                    var htmlline = htmlline + "<tr><td>" + items[ii] + "</td>";
                    var name = self.getName(items[ii]);
                    if (name.length > 25)
                        name = name.substring(0, 25);
                    for (var m = 0; m < choices.length; m++) {
                        var value = self.getName(choices[m]);
                        htmlline = htmlline + "<td><input type='radio' name='" + name + "' id='" + name + "' value='" + value + "'></td>";
                    }
                    htmlline = htmlline + "</tr>\n";
                }
                $('.preview tbody').html(htmlline);
            });

        }
;
        self.checkboxlist_formjs = function () {
            $('#QuestionText').blur(function () {
                $('.preview .label').text($('#QuestionText').val());
            });
            $('#Choices').blur(function () {
                var choices = $('#Choices').val().split('\n');

                var htmlline = "<ul>";
                for (var ii = 0; ii < choices.length; ii++) {

                    var name = self.getName(choices[ii]);
                    if (name.length > 25)
                        name = name.substring(0, 25);
                    htmlline = htmlline + "<li><input type='checkbox' name='" + name + "' id='" + name + "' value='" + choices[ii] + "'><span class='label'>" + choices[ii] + "</span></li>";
                }
                htmlline = htmlline + "</ul>";
                $('.preview .choices').html(htmlline);
            });
        }
;
        self.menu_component_formjs = function () {
            $("#addMenuItem").click(
                function (e) {

                    e.preventDefault();
                    var text = $('#label').val();
                    var link = $('#target').val();
                    var menuItem = "<li><a href='" + link + "'>" + text + "</a></li>";

                    var itm = $('.preview .dropdown-menu').html() + menuItem;
                    $('.preview .dropdown-menu').html(itm)

                    $('#label').val("");
                    $('#target').val("");
                }
            );

        };

    };

    return FormBuilder;
});
