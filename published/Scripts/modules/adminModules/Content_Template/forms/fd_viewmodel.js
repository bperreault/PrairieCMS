define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext) {
        /*

        HeroBar  -  <div class="hero-unit">  <h1>{Heading}</h1>  <p>{Tagline}</p>  <p>    <a class="btn btn-primary btn-large">      {Learn more}    </a>  </p></div>
        Ad  -  <div class="ad">{content}</div>
        ContentArea  -  <div>{content}</div>
        Notices  -  <div class="alert">{content}</div>
        button  -  <input type="button" id="[name]" value="[label]">
        checkbox  -  [label]<input type="checkbox" id="[name]" name="[name]" value="[value]" />[text]
        combobox  -  [label]<br/><select id="[name]" name="[name]"> [repeat] <option value="[value]">[text]</option>[endrepeat]</select>
        label  -  [label]
        multiline-textbox  -  [label]<br/><textarea rows="10" cols="80" id="[name]" name="[name]"></textarea>
        radiobutton  -  <input type="radio" name="[name]" id="[name]" value="[value]" /> [text]
        textbox  -  [label]<br/><input type="text" name="[name]" id="[name]" />
        ranking  -  <table>  <tr><th>[text]</th>  [repeat]  <th><span>[frequencyvalue]</span></th>  [endrepeat]  </tr>  [repeat]  <tr><td style="text-align:left; padding-bottom:8px;">[value]</td>  [repeat]  <td><input type="radio" name="[name]" id="[name]" value="[value]" /></td>  [endrepeat]  </tr>  [endrepeat]  </table>
        checkboxlist  -  [label] <br />    [repeat]  <input type="checkbox" name="[name]" id="[name]" value="[value]" />[text]  [endrepeat]
        menu_component  -  <ul class="dropdown-menu" role="menu" >{menu_component}</ul>

        */
        var self = this;
        self.templateText = ko.observable("");
        self.itemObject = ko.observable();
        self.itemObjectHtml = ko.observable("");

        self.initialize = function () {

        };

        self.setItem = function (itemobject) {
            if (!itemobject)
                return;
            self.itemObject(itemobject);
            self.templateText(itemobject.inputForm);
            self.itemObjectHtml(itemobject.html);

            //based on type of object what are our inputs. - inputForm comes with the control html object. data from inputForm is matched
            // back into the html (that is labels and names) by the class of the dom element matching the id of the inputForm element.
            //itemobject.text is the type of control we're building.
            //itemobject.html is the html of the control we're building

        }

    };


    return ViewModel;
});

