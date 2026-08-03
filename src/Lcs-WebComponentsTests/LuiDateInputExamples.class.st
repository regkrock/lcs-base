Class {
	#name : 'LuiDateInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateInputExamples >> birthdayOfPerson [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person minimumDate maximumDate birthDate dateOfBirthSlot |
	self ensureCurrentSystemIsPrototypeSystem.
	dateOfBirthSlot := LxxPerson slotDefinitionNamed: 'dateOfBirth'.
	birthDate := Date
			newDay: 1
			month: 1
			year: 2026.
	maximumDate := Date today.
	minimumDate := Date
			newDay: maximumDate dayOfMonth
			month: maximumDate monthIndex
			year: maximumDate year - 120.
	person := LxxPerson new.
	person dateOfBirth: birthDate.
	component := LuiDateInput onSlotNamed: 'dateOfBirth' model: person.
	self wrapComponent: component.
	self assert: dateOfBirthSlot minimum equals: minimumDate.
	self assert: dateOfBirthSlot maximum equals: maximumDate.


	expectedHtml := '%<input id="15574312" data-name="dateOfBirth" data-StClass="LuiDateInput" min="<2s>" max="<1s>" class="inputField" onblur="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#15574312&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="<3s>" type="date"/>'
	expandMacrosWith: maximumDate yyyymmdd with: minimumDate yyyymmdd with: birthDate yyyymmdd.

	self assertRendered: component equals: expectedHtml.

	^ component
]

{ #category : 'examples' }
LuiDateInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml today |
	today := Date today yyyymmdd.
	component := LuiDateInput named: 'datePicker' model: Date today.
	self wrapComponent: component.
	expectedHtml := '%<input id="52549980" data-name="datePicker" data-StClass="LuiDateInput" class="inputField" name="1" onblur="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;2&quot;,&quot;3=&quot;+encodeURIComponent($(&quot;#52549980&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;4&quot;)}})" value="<1s>" type="date"/>'  expandMacrosWith: today.
	self assertRendered: component equals: expectedHtml.

	^ component
]
