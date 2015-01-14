angular.module('ui.bootstrap.demo', ['ui.bootstrap']);
angular.module('ui.bootstrap.demo').controller('CarouselDemoCtrl', function ($scope) {
  $scope.myInterval = 5000;
  var slides = $scope.slides = [];
  $scope.addSlide = function(image_name) {
    var newWidth = 600 + slides.length + 1;
    slides.push({
      image: image_name,
      text: ''
    });
  };
  for (var i=1; i<6; i++) {
    $scope.addSlide('assets/home_banner/pic' + i + '.jpg');
  }
});
