///@function eval_concatenate(value)
///@arg value
var result = argument0;
while(token_get_value(eval_get_current_token())=="+"){
	eval_eat_token(TokenType.MATH);
	result = result + eval_factor();
}
return result;