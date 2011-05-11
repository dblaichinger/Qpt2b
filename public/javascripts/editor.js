// ------------------------------------------
// Motive Class
var Motiv = $.Class({    

    init: function(object) {

        that = this;
        CANVAS = "#canvas";
        GRID = 20;

        this.cssClass = "motiveIn";

        this.objectID = object.attr("id");
        //console.log("InitParent: " + this.objectID);

        //this.obj = this.addToCanvas(object);
    },

    addToCanvas: function(obj) {
    	var clone = obj.clone().appendTo(CANVAS).removeClass("motiv").addClass(this.cssClass);
    	return clone;
    },

    doDraggable: function() {
        this.obj.parent('.ui-wrapper').draggable({ containment: CANVAS, cancel: null,  grid: [ GRID, GRID ], drag: function(event, ui) { $("#deleteButton").hide() } });
    },

    doMouseover: function(objectID) {
    		console.log("that.ID:" + that.objectID);
            var id = that.objectID;
    		var pos = that.obj.offset();
				
				// Show delete button
				$("#deleteButton").css({ "left" : pos.left + "px", "top" : pos.top + "px" }).show().bind('click', function() { 
						$("#" + id + ".motiveIn").remove();
						$(this).hide();
				});
    },

    doMouseout: function() {
    		$("#deleteButton").hide();
    },

    doClick: function() {
    		console.log("Parent click:" + this.objectID);
            focusID = this.objectID;
            console.log("focusID:" + focusID);
            //$("#" + this.objectID).hasClass("motiveIn").remove();
    }
});

var Picture = Motiv.extend({

    init: function(object) {        
        this._parent.init(object);

        this.obj = this._parent.addToCanvas(object);

        this.objectID = object.attr("id");

        var theHeight = (object.height() < 0) ? 30 : object.height();
        var theWidth = (object.width() < 0) ? 30 : object.width();

        this.height = theHeight;
        this.width  = theWidth;
        this.ratio  = this.width / this.height;

        this.minResize = 25;

        this.doResizeable();
        this.doDraggable();

        this.obj.bind('click', function(){ that.doClick(); });
        this.obj.bind('mouseover', function(){ that.doMouseover(); });
        this.obj.bind('mouseout', function(){ that.doMouseout(); });
    },

    doResizeable: function() {
          this.obj.resizable({
						maxHeight: 180, //this.height,
						maxWidth: 180,//this.width,
						minHeight: this.minResize,
						minWidth: this.minResize,
						grid: GRID,
						aspectRatio: this.ratio
					});
    },

    doDraggable: function() {
        this._parent();
    }

});

var Textfield = Motiv.extend({

    init: function(object) {
  			this._parent.init(object);

				this.objectID = object.attr("id");

    		this.doResizeable();
        this.doDraggable();
    },

    doResizeable: function() {
        this.obj.resizable({         		
						resize: function(event, ui) { 
							var h = that.obj.height() / 10;
							var leng = that.obj.val().length * ( that.obj.height() / 10);

							that.obj.css({"font-size" : h + "em"});
							that.obj.attr("size" , leng);
						}
        });
    },

    doDraggable: function() {
        this._parent();
    },

    doClick: function() {
    	this.obj.focus();
    }
});
// ------------------------------------------

var focusID = -1;
$(document).ready(function() { 

		$("#deleteButton").hide();

        var elements = new Array();
		
		$(".motiv").click(function() 	 { elements.push(new Picture( $(this) )); });//var object = new Picture( $(this) ); });
		$(".textField").click(function() { var object = new Textfield( $(this) ); });

		$( "#slider" ).slider({
			value:1,
			min: 0.8,
			max: 4,
			step: 0.1,
			slide: function( event, ui ) {
				$( "#amount" ).val( "Size: " + ui.value );
				$(".textField").css({ "font-size" : ui.value + "em" });
			}
		});

        $( "#rotator" ).slider({
            value:0,
            min: -180,
            max: 180,
            step: 1,
            slide: function( event, ui ) {
                // Remove parents "ui-wrapper" overflow hidden
                var g = $("#" + focusID).parent().css({ "overflow" : ""});

                // Rotate Image
                $("#" + focusID).css({ "-moz-transform" : 'rotate('+ui.value+'deg)', "-webkit-transform" : 'rotate('+ui.value+'deg)' });
            }
        });
    
    
		$( "#amount" ).val( "Size: " + $( "#slider" ).slider( "value" ) );

        $("#font").change(function () {
          var font = $("#font option:selected").val();             
          $(".textField").css({ "font-family" : font });            
        }).change();
});