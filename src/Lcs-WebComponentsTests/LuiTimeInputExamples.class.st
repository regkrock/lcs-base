Class {
	#name : 'LuiTimeInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiTimeInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml timeNow |
	timeNow := Time now.
	component := LuiTimeInput named: 'timePicker' model: timeNow.
	self assert: component codec class equals: LuiTimeCodec.
	self assert: component codec class equals: LuiTimeCodec.
	self wrapComponent: component.

	expectedHtml := '%<input id="109785709" data-name="timePicker" data-StClass="LuiTimeInput" class="inputField" name="1" onblur="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;2&quot;,&quot;3=&quot;+encodeURIComponent($(&quot;#109785709&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;4&quot;)}})" value="<1s>" type="time"/>' expandMacrosWith: timeNow asString.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTimeInputExamples >> timeInputForSlotWithMinimumAndMaximum [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person slot newTime |
	self ensureCurrentSystemIsPrototypeSystem.
	newTime := (Time midnight addSeconds: 3).
	person := LxxPerson new.
	slot := LxxPerson slotDefinitionNamed: 'time'.
	component := LuiTimeInput onSlotNamed: 'time' model: person.
	self assert: slot minimum equals: Time midnight.
	self assert: slot maximum equals: Time noon.
	self assert: slot validationRules collection size = 1 .
	self assert: slot validationRules collection any class == LcsRangeRule.
	self wrapComponent: component.

	expectedHtml := '%<input id="242751071" data-name="time" data-StClass="LuiTimeInput" max="12:00 pm" class="inputField" min="12:00 am" onblur="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#242751071&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="<1s>" type="time"/>' expandMacrosWith: Time midnight asString.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTimeInputExamples >> updateTime [
	<gtExample>
	<after: #clearUnitOfWork>
	| component newTime expectedHtml |
	self ensureCurrentSystemIsPrototypeSystem.
	newTime := (Time midnight addSeconds: 3).
	component := self timeInputForSlotWithMinimumAndMaximum.
	component handleCallbackValue: newTime asString.
	self assert: component model time equals: newTime.
	expectedHtml := '%<input id="242751071" data-name="time" data-StClass="LuiTimeInput" max="12:00 pm" class="inputField" min="12:00 am" onblur="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#242751071&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="<1s>" type="time"/>' expandMacrosWith: newTime asString.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTimeInputExamples >> updateTimeWithInvalidValue [
	<gtExample>
	<after: #clearUnitOfWork>
	| component newTimeString |
	self ensureCurrentSystemIsPrototypeSystem.
	newTimeString := (Time noon addSeconds: 120) asString.
	component := self timeInputForSlotWithMinimumAndMaximum.
	self assert: component model time equals: Time midnight.
	self deny: (component cssClasses includes: (LuiCssClassesMap / #inputFieldError)).
	self should: [ component applyCallbackValue: newTimeString ] raise: LcsSlotValidationError.
	self assert: component model time equals: Time midnight.

	component handleCallbackValue: newTimeString.
	self assert: (component cssClasses includes: (LuiCssClassesMap / #inputFieldError)).
	^ component
]
