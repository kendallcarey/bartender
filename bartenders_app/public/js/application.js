$(document).ready(function() {
  bindAll();
  google.maps.event.addDomListener(window, 'load', initialize);
  $('.location').on('click', getLocation)
});


// function multiplyMarkers() {
//   putMarkers();
//   var data
//   debugger

// }
// }
function getLocation(event) {
  event.preventDefault();
  // var throb = Throbber();
  // throb.appendTo( document.getElementById( 't1' ) );
  // throb.start();
  navigator.geolocation.getCurrentPosition(putMarkers, error, options)
}

function addMarkers(myLatlng) {
    marker = new google.maps.Marker({
    position: myLatlng,

    title:"Hello World!"
  });
  marker.setMap(map);
}

function putMarkers(pos) {

  var userNum = $('.search').attr("data")
  requestAjax = $.ajax({
    type:"GET",
    url:"/users/" + userNum + "/update_bars?coordinates=" + pos.coords.latitude + "," + pos.coords.longitude
  })
  position = {"latitude": pos.coords.latitude,"longitude": pos.coords.longitude}
  requestAjax.done(function(data) {
    for( var i = 0; i < data.bars.length; i++ ) {
      if(data.bars[i][0] && data.bars[i][1]){
        console.log(data.bars[i])
        addMarkers(new google.maps.LatLng(data.bars[i][0], data.bars[i][1]));
      }
    }
  });
    showBars();
}

function showBars(pos) {
  requestAjax = $.ajax({
    type:"GET",
    url:"/show_bars/"+ position.latitude + "," + position.longitude
  })
  requestAjax.done(function(data) {
    $('.show-bars').append(data)
  });
}

// To add the marker to the map, call setMap();

function bindAll() {
  $('.show-bars').on('click', ".span_1_of_4", changeCSS)
  $('form').on('submit', doubleCheck);
}


function doubleCheck(e) {
  if ( $('#input-password').val() !== $('#double-check').val() ) {
    e.preventDefault();
    alert('The passwords do not match');
  }
}

function changeCSS() {
  this.style.width = "100%"
  this.style.textAlign = "left"
  this.style.paddingLeft = "100px"
  $(this).find('.bar-pic').addClass('selected-bar-pic')
  $(this).find('.bar-info').addClass('selected-bar-info')
  if(!$(".partial").is(":visible")){
    addPartial(this);
  }
}

function addPartial(event, div) {
  var container = event
  requestAjax = $.ajax({
    type:"GET",
    url:"/render-partial"
  })
  requestAjax.done(function(data) {
    $(container).append(data)
  });
}

var options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
};

// function success(pos) {

//   console.log('Your current position is:');
//   console.log('Latitude : ' + crd.latitude);
//   console.log('Longitude: ' + crd.longitude);
//   console.log('More or less ' + crd.accuracy + ' meters.');
// };

function error(err) {
  console.warn('ERROR(' + err.code + '): ' + err.message);
};


// function createBartender(event) {
//   event.preventDefault();
//   var BartenderName = $('input.bar_name').val();
//   var specialty = $('input.specialty').val();
//   requestAjax = $.ajax({
//     type:"POST",
//     url:"/bartender/new",
//     data: {todo_attributes: {todo_content: todoName}}
//     });
//   requestAjax.done(updateDOMAddB);
//   }

// function updateDOMAddB(data) {
//   var parsedData = JSON.parse(data);
//   var todo = buildTodo(parsedData.todo.todo_content, parsedData)
//   $('.todo_list').append(todo)
//   $('form')[0].reset()
// }
function initialize() {
  latlng = new google.maps.LatLng(37.7833, -122.4167);
  var myOptions = {
    zoom: 12,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById("map-canvas"),
    myOptions);

};



// var map = new google.maps.Map(document.getElementById("map-canvas"),
//   myOptions);
// var marker = new google.maps.Marker({
//   position: new google.maps.LatLng(coords),
//   map: map
// });




// function getLocation() {
//   if (navigator.geolocation) {
//     coords = navigator.geolocation.getCurrentPosition();
//   } else {
//     alert('Cannot find your location!');
//   }
// }

// function showPosition(position) {
//    position.coords.latitude +
//   "<br>Longitude: " + position.coords.longitude;
// }
  // function loadScript() {
  //   var script = document.createElement('script');
  //   script.type = 'text/javascript';
  //   script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&' +
  //   'callback=initialize';
  //   document.body.appendChild(script);
  // }
