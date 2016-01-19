$( document ).ready(function() {

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

                            $(dropped).removeClass("btn-danger").removeClass("btn-info")
                            $(dropped).addClass("btn-info")

                            $(dropped).appendTo(droppedOn);      

                            add_team_member(dropped, droppedOn)
                              
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

                              $(dropped).removeClass("btn-danger").removeClass("btn-info")
                              $(dropped).addClass("btn-danger")

                              $(dropped).appendTo(droppedOn);   

                              delete_team_member(dropped)
                              }
                            }
                          );

});

function add_team_member(elem, droppedOn) {  

  $.ajax({
    type: 'POST',
    url: '/admin/team_members',
    data: {team_member: {member_id: $(elem).data("user-id"), team_id: $(droppedOn).data("team-id") }, old_team_member_id: $(elem).data("team-member-id")}
  })
  return false;
}

function delete_team_member(elem) {
  $.ajax({
    url: '/dissociate_team_member',    
    data: {id: $(elem).data("team-member-id")},
    type: 'POST'

    
  })
  return false;
}