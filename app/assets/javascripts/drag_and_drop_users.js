$( document ).ready(function() {
  console.log( "ready!" );
  $(".draggable").draggable({ cursor: "crosshair",

                              revert: "invalid",
                              helper: function(){
                                      $copy = $(this).clone();
                                      return $copy;},
                              appendTo: 'body',
                              scroll: false
                            });
  $(".team-droppable").droppable({ accept: ".draggable", 
                          drop: function(event, ui) {
                            console.log("drop");
                            $(this).removeClass("border").removeClass("over");
                            var dropped = ui.draggable;
                            var droppedOn = $(this);
                            $(dropped).appendTo(droppedOn);      
                              
                          }, 
                          over: function(event, elem) {
                            $(this).addClass("over");
                             console.log("over");
                          },
                          out: function(event, elem) {
                            $(this).removeClass("over");
                          }
                        });
  

  $(".unallocate-droppable").droppable({ accept: ".draggable", 
                            drop: function(event, ui) {
                              console.log("drop");
                              $(this).removeClass("border").removeClass("over");
                              var dropped = ui.draggable;
                              var droppedOn = $(this);
                              $(dropped).appendTo(droppedOn);      
                              }
                            }
                          );

});

