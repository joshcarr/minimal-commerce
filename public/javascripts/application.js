// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var Validate = (function() {

var numberPattern = new RegExp(/^[0-9]+$/);
var decimalNumberPattern = new RegExp(/^-?\d+(\.\d+)?$/);
//var urlPattern = new RegExp(/^(?:http|https|ftp)(?::\\/{2}[\\w]+)(?:[\\/|\\.]?)(?:[^\\s\"]*)/);
//RegExp(/^(http:\/\/|https:\/\/|ftp:\/\/)?([\d\w]+)?(.[\d\w]+){1,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*$/);

return {
  Number: function(numberToValidate, allowDecimals)
{
///<returns type="Boolean" />
///<usage>Validate.Number(5) - number</usage>
///<usage>Validate.Number(0.5, true) - decimal number</usage>

if (!numberToValidate) {
  alert('numberToValidate is missing');}
  var tempNumber = '"'+numberToValidate+'"';
  if (allowDecimals) {

   return (!isNaN(numberToValidate) &&
          (tempNumber.indexOf(".") >= 0 || 
	       tempNumber.indexOf(",") >= 0) &&
           decimalNumberPattern.test(numberToValidate));
   }
  else {
    return (!isNaN(numberToValidate) &&
           (!tempNumber.indexOf(".") >= 0 || tempNumber.indexOf(",") >= 0) &&
            numberPattern.test(numberToValidate));
    }
  },
  

  //URL: function(urlToValidate) {
	// return (urlPattern.test(urlToValidate));
  //},


  Range: function(numberToValidate, lowerBound, upperBound, allowDecimals)
  {
  ///<returns type="Boolean" />
  ///<usage>Validate.Range(0.3, 0.5, 4, true);</usage>
  ///<usage>Validate.Range(3, 0, 4, false);</usage>

	if (!numberToValidate) {alert('numberToValidate is missing');return false;}
	if (!lowerBound) {alert('lowerBound is missing');return false;}
	if (!upperBound) {alert('upperBound is missing');return false;}

	if (allowDecimals) {
	if (!Validate.Number(numberToValidate, true)) {
	alert('The argument "numberToValidate" is not a valid decimal number!');
	return false;
	}
	}
	else {
		if (!Validate.Number(numberToValidate)) {
		alert('The argument "numberToValidate" is not a valid number!');
		return false;
		}
	}
    return (numberToValidate > lowerBound) && (numberToValidate < upperBound);
   }
   };
})();


