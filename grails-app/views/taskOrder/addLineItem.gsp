<%@ page import="fta.vacs.domain.TaskOrder" %>
<%@ page import="fta.vacs.domain.Component" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<tr class="${(params.number.toInteger() % 2) == 0 ? 'even' : 'odd'}">
	<td><g:select name="componentIds.${params.number.toInteger()}" from="${Component.list().sort{ it.name }}" optionKey="id" optionValue="${{StringUtils.rightPad(it.name, 20, ' - ') + ' ' + it.description}}" value=""  noSelection="['':'-Select Component-']"/></td>
	<td><g:textField name="quantities.${params.number.toInteger()}" size="5" value="" /></td>								                            	
</tr>