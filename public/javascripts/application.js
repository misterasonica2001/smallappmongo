// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function textCounter(field, cntfield, maxlimit)
{	
	if (field.value.length > maxlimit)
		field.value.substring(0, maxlimit);
	else
		cntfield.value = maxlimit - field.value.lenght;
}