// ------------------------------------------
// Motive Manager Class
function MotivManager(focusManager) {    
    
    this.focusManager = focusManager;
    this.elements = new Array();
    that = this;

    this.isTextbox = false;

    this.addElement = function(object) {
        var randomID = this.randomId();
        this.focusManager.setFocus(randomID);

        this.elements.push(new Picture( randomID, object, this.focusManager ));
    }

    this.addText = function() {
        var randomID = this.randomId();
        this.focusManager.setFocus(randomID);

        this.elements.push(new Textfield( randomID, this.focusManager ));
    }

    this.removeElement = function() {       
        // Remove from elements-Array
        $.each(this.elements, function(i,ele) {            
            if(ele.objectID == this.focusManager.focusID)
                that.elements.splice(i);
        });

        // Remove Object
        $("#" + this.focusManager.focusID).remove();
        $("#deleteButton").hide();
    } 

    this.setTextbox = function() {
        if(this.isTextbox == false) {
            this.isTextbox = true;
            $("#newText").css({ 'border' : '1px solid #880000' });
            $("#editorWrapper").css({ 'cursor' : 'text' });
        } else {
            this.isTextbox = false;
            $("#newText").css({ 'border' : '0px solid #880000' });
            $("#editorWrapper").css({ 'cursor' : 'auto' });
        }
    }

    // ---------------------------
    // WE DONT NEED THIS
    this.printElements = function() {
        $("#text").html();
        for(var i=0; i < this.elements.length; i++) {
                $("#text").append("ID:" + this.elements[i].objectID + " x:" + this.elements[i].x + " y:" + this.elements[i].y + '<br />');
        }
    }

    this.printMotive = function() {
        console.log($('.motivIn').length);
        $.each($('.motivIn'), function() {
            var w = $(this).width();
            var h = $(this).height();
            var id = $(this).attr("id");
            var pos = $(this).offset();
            var left = pos.left;
            var top = pos.top;

            $("#text").append("ID:" + id + " w:" + w + " h:" + h + " x:" + left + " y:" + top + "<br />");            
        });
    }
    // ---------------------------

    this.randomId = function() {
        return Math.floor(Math.random() * 1000);
    }

    this.doXml = function() {
        
        var output = '';   
        var pre = '';

        output += '<?xml version="1.0" encoding="UTF-8"?>\n';
        output += '<motive>\n';

        // Print all images
        for(var i=0; i < this.elements.length; i++) {

            if(this.elements[i].type == "IMAGE")
                output += '\t<image id="'+ this.elements[i].objectID +'" source="'+this.elements[i].imageID+'" width="'+ this.elements[i].width +'" height="'+ this.elements[i].height +'" x="'+ this.elements[i].x +'" y="'+ this.elements[i].y +'" rotation="'+ this.elements[i].angle +'" />\n';
            else
                output += '\t<text id="'+ this.elements[i].objectID +'" caption="'+this.elements[i].caption+'" size="'+ this.elements[i].size +'" x="'+ this.elements[i].x +'" y="'+ this.elements[i].y +'" rotation="'+ this.elements[i].angle +'" />\n';
        }

        output += '</motive>';
        $("#xmlOutput").html(output);
    }

    this.setRotation = function(elementID, angle){
        that.elements[that.getIndex(elementID)].angle = angle;
    }

    this.getIndex = function(id) {        
        for(var i=0; i < this.elements.length; i++) {
            if(this.elements[i].objectID == id)
                return i;
        }
    }

    this.reset = function() {
        $('#textEditor').hide();
        $('#imageEditor').hide();
        $("#deleteButton").hide();
    }
};

// -----------------------------------------------
// Picture Class
function Picture(_id, object, fManager) {     

    this.doResizeable = function() {
          this.obj.resizable({
                        maxHeight: 180,
                        maxWidth: 180,
                        minHeight: this.minResize,
                        minWidth: this.minResize,
                        grid: GRID,
                        ghost: true,
                        aspectRatio: this.ratio,
                        stop: function(event, ui) {                                                       
                            that.width =  Math.round(ui.size.width);
                            that.height =  Math.round(ui.size.height);
                        }
                    });
    }

    this.addToCanvas =  function(object) {           
        var clone = object.clone().appendTo(CANVAS).removeClass("motiv").addClass(this.cssClass).attr("id", this.objectID);        
        return clone;
    }

    this.doDraggable = function() {
        this.obj.parent('.ui-wrapper').draggable({ 
                containment: CANVAS, 
                cancel: null,  
                grid: [ GRID, GRID ], 
                drag: function(event, ui) { $("#deleteButton").hide() },
                stop: function(event, ui) { 
                    var pos = ui.offset;
                    that.x = pos.left;
                    that.y = pos.top;
                }
        });
    }

    this.doMouseover = function(objectID) {
            var id = that.objectID;
            var pos = that.obj.offset();
            
            var posLeft = pos.left - 15;
            var posTop = pos.top - 15;
                // Show delete button
                $("#deleteButton").css({ "cursor" : "pointer", "left" : posLeft + "px", "top" : posTop + "px" }).show().bind('click', function() { 
                        $("#" + that.objectID).remove();
                        $(this).hide();
                });
    }

    this.doMouseout = function() {
            //$("#deleteButton").hide();
    }

    this.doClick = function() {
            console.log("ID click:" + this.objectID);
            this.focusManager.setFocus(this.objectID);        
    }

    const CANVAS = "#canvas";
    const GRID = 20;

    this.focusManager = fManager;

    var that = this;

    this.cssClass = "motivIn";
    this.objectID = _id;
    this.obj = this.addToCanvas(object);        
    this.imageID = object.attr("id");

    this.height = (object.height() < 0) ? 30 : object.height();
    this.width  = (object.width() < 0) ? 30 : object.width();
    this.ratio  = this.width / this.height;

    this.x = 0;
    this.y = 0;
    this.angle = 0;
    this.type = "IMAGE";

    this.minResize = 25;    

    this.doResizeable();
    this.doDraggable();

    this.obj.bind('click', function(){ that.doClick(); });
    this.obj.bind('mouseover', function(){ that.doMouseover(); });
    this.obj.bind('mouseout', function(){ that.doMouseout(); });
};

// -----------------------------------------------
// Textfield Class
var Textfield = function Picture(_id, fManager) {

    this.create = function() {        
        return $('<input id="'+this.objectID+'" type="text" class="textIn" value="Text here">');
    }

    this.appendToCanvas = function() {
        $("#canvas").append(this.obj);
        this.obj.css({'background' : 'none', 'color' : '#333333', 'border' : '1px dotted #000000' });
    }


    this.doResizeable = function() {
        this.obj.resizable({          
                        resize: function(event, ui) { 
                            var h = that.obj.height() / 10;
                            var leng = that.obj.val().length * ( that.obj.height() / 10);

                            //that.obj.css({"font-size" : h + "em"});
                            //that.obj.attr("size" , leng);
                        }
        });
    }

    this.doDraggable = function() {
        this.obj.parent('.ui-wrapper').draggable({ 
                containment: CANVAS, 
                cancel: null,  
                grid: [ GRID, GRID ], 
                drag: function(event, ui) { $("#deleteButton").hide() },
                stop: function(event, ui) { 
                    var pos = ui.offset;
                    that.x = pos.left;
                    that.y = pos.top;
                }
        });
    }

    this.doClick = function() {
        this.focusManager.setFocus(this.objectID); 
        this.obj.focus();
    }

    const CANVAS = "#canvas";
    const GRID = 20;

    this.focusManager = fManager;
    var that = this;

    this.x = 0;
    this.y = 0;
    this.angle = 0;
    this.size = 0;
    this.caption = "";

    this.type = "TEXT";
    this.objectID = _id;

    this.obj = this.create();
    this.appendToCanvas();
    
    this.cssClass = "textIn";    
    
    this.doResizeable();
    this.doDraggable();
    this.obj.bind('click', function(){ that.doClick(); });

    //this.obj.css({'background' : 'none', 'color' : '#333333', 'border' : '1px dotted #000000' }).removeClass('textField').addClass('textIn');
};

// -----------------------------------------------
// FocusManager Class
// Should be singleton
function FocusManager() {
    
    this.focusID = -1;
    that = this;

    this.setFocus = function(id) {
        this.focusID = id;
        console.log("FM.set:" + this.focusID);
        $('#textEditor').hide();
        $('#imageEditor').hide();
        $(".motivIn").css({"border" : "1px dotted #000000"});
        $(".textIn").css({"border" : "1px dotted #000000"});
        $("#" + this.focusID).css({"border" : "1px dotted #ff6600"});

        // SHOW edit tools
        if($("#" + this.focusID).is('input')) {
            $('#textEditor').show("slow");
        } else if($("#" + this.focusID).is('img')) {
            $('#imageEditor').show("slow");
        }
    }

    this.getFocus = function() {
        return this.focusID;
    }
};

var focusManager = new FocusManager();
var motivManager = new MotivManager(focusManager);

// ------------------------------------------
$(document).ready(function() { 

        motivManager.reset();
        
        $(".motiv").click(function() {   
            motivManager.addElement( $(this) );
        });

        $("#newText").click(function() {   

            motivManager.setTextbox();

        });

        $("#addTextToCanvas").click(function() {

            //motivManager.addElement(  );
        });

        $("#canvas").click(function() {

            if(motivManager.isTextbox == true) {
                motivManager.addText();
                motivManager.setTextbox();
            }
            
        });

        $("#editorSaveButton").click(function() {
            if($('.motivIn').length > 0 || $('.textIn').length > 0 )
                motivManager.doXml();         
            else
                alert("Keine Elemente vorhanden!");
        });
        

        $( "#slider" ).slider({
            value:1,
            min: 0.8,
            max: 4,
            step: 0.1,
            slide: function( event, ui ) {
                $( "#amount" ).val( "Size: " + ui.value );
                $("#" + focusManager.focusID).css({ "font-size" : ui.value + "em" });
            }
        });

        $( "#rotator" ).slider({
            value:0,
            min: -180,
            max: 180,
            step: 1,
            slide: function( event, ui ) {
                // Remove parents "ui-wrapper" overflow hidden
                var g = $("#" + focusManager.focusID).parent().css({ "overflow" : ""});

                // Rotate Image
                $("#" + focusManager.focusID).css({ "-moz-transform" : 'rotate('+ui.value+'deg)', "-webkit-transform" : 'rotate('+ui.value+'deg)' });                
                
                // Save it                
                motivManager.setRotation(focusManager.focusID, ui.value);
            }
        });
    
    
        $( "#amount" ).val( "Size: " + $( "#slider" ).slider( "value" ) );

        $("#font").change(function () {
          var font = $("#font option:selected").val();             
          $("#" + focusManager.focusID).css({ "font-family" : font });            
        }).change();

        $(document).keyup(onKeyUp);
        function onKeyUp(evt) {
            switch (evt.keyCode) {
                // DELETE KEY
                case 46:
                        motivManager.removeElement();
                        break;
            }
        }
});