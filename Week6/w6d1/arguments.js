var sum = function() {
  var result = 0;
  for (var i = 0; i < arguments.length; i++) {
    result += arguments[i];
  }

  return result;
};

// console.log(sum(1,2,3,4,5));

Function.prototype.myBind = function(context) {
  var that = this;
  var args = Array.prototype.slice.call(arguments, 1);
  return function() {
    var args2 = Array.prototype.slice.call(arguments);
    that.apply(context, args.concat(args2));
  };
};

var curriedSum = function (numArgs) {
  var numbers = [];
  var _curriedSum = function (num) {
    numbers.push(num);
    if (numbers.length === numArgs){
      return numbers.reduce(function(prevVal, currVal, idx, array) {
        return prevVal + currVal;
      });
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
};

// var sum = curriedSum(4);
// console.log(sum(5)(2)(4)(3)); // => 14
//

Function.prototype.curry = function (numArgs) {
  var that = this;
  var numbers = [];
  var func = function(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return that.apply(that, numbers);
    } else {
      return func;
    }
  };

  return func;
};
