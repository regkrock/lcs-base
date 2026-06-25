Class {
	#name : 'LuiLabelWithInputComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiLabelWithInputComponentExamples >> expectedMainSkillsAsRadioGroupHtml [
	^'<div data-name="mainSkillRadioLabelAndInput" data-StClass="LuiLabelWithInputComponent" class="labelAndInputRow"><label id="44892641" data-name="mainSkillLabel" data-StClass="LuiLabel" for="mainSkill">Main Skill</label><div id="6714643" data-name="mainSkillRadioButtons" data-StClass="LuiRadioButtons" class="radioButtons"><input id="220995112" data-name="unknown_RadioButton" data-StClass="LuiRadioButton" value="unknown" type="radio"/><label id="57874248" data-name="unknown_RadioButtonLabel" data-StClass="LuiLabel" for="220995112"></label><input id="37212082" data-name="1_RadioButton" data-StClass="LuiRadioButton" value="1" type="radio"/><label id="77981290" data-name="1_RadioButtonLabel" data-StClass="LuiLabel" for="37212082">Skill 1</label><input id="33927364" data-name="2_RadioButton" data-StClass="LuiRadioButton" value="2" type="radio"/><label id="235682292" data-name="2_RadioButtonLabel" data-StClass="LuiLabel" for="33927364">Skill 2</label><input id="30642646" data-name="3_RadioButton" data-StClass="LuiRadioButton" value="3" type="radio"/><label id="124947838" data-name="3_RadioButtonLabel" data-StClass="LuiLabel" for="30642646">Skill 3</label></div></div>'
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> hasRedHairBooleanAsCheckboxWithEmptyLabelComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person inputComponent labelComponent|
	self ensureCurrentSystemIsPrototypeSystem.

	person := LxxPerson new.
	
	component := 
		LuiLabelWithInputComponent 
			onSlotNamed: 'hasRedHair'
			model: person
			widgetClass: LuiCheckboxAndLabel.

	self assert: component componentName
			equals: 'hasRedHairLabelAndInput'.
	self assert: component labelComponentName 
			equals: 'hasRedHairLabelAndInputLabel'.
	self assert: component inputComponentName
			equals: 'hasRedHairLabelAndInputInput'.

	self assert: component hasLabelComponent.
	labelComponent := component labelComponent.
	self assert: labelComponent notNil.

	self assert: component hasInputComponent.
	inputComponent := component inputComponent.
	self assert: inputComponent notNil.
	self assert: inputComponent inputComponent notNil.
	self assert: inputComponent labelComponent notNil.
	
	self assertRendered: component equals: self hasRedHairBooleanExpectedHtml.
	^ component
]

{ #category : 'private' }
LuiLabelWithInputComponentExamples >> hasRedHairBooleanExpectedHtml [
	^'<div data-name="hasRedHairLabelAndInput" data-StClass="LuiLabelWithInputComponent" class="labelAndInputRow"><label id="47040735" data-name="hasRedHairLabelAndInputLabel" data-StClass="LuiLabel"></label><div id="141918531" data-name="hasRedHairLabelAndInputInput" data-StClass="LuiCheckboxAndLabel" class="radioButtonAndLabel"><input id="121675685" data-name="hasRedHair" data-StClass="LuiCheckbox" name="1" type="checkbox"/><input name="2" type="hidden"/><label id="223971761" data-name="hasRedHairLabel" data-StClass="LuiLabel" for="121675685">Has Red Hair</label></div></div>'
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameInputComponent [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<input id="17819216" data-name="lastName" data-StClass="LuiTextInput" placeholder="Last Name" class="inputField" name="1" value="Smith" type="text"/>'.
	^ self assertRendered: self lastNameLabelWithInputComponent inputComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameLabel [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<label id="1052112" data-name="lastNameLabel" data-StClass="LuiLabel" for="lastName">Last Name</label>'.
	^ self assertRendered: self lastNameLabelWithInputComponent labelComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameWithInLabelAndInputComponent [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<div data-name="lastNameLabelAndInput" data-StClass="LuiLabelWithInputComponent" class="labelAndInputRow"><label id="1052112" data-name="lastNameLabel" data-StClass="LuiLabel" for="lastName">Last Name</label><input id="17819216" data-name="lastName" data-StClass="LuiTextInput" placeholder="Last Name" class="inputField" name="1" value="Smith" type="text"/></div>'.
	^ self assertRendered: self lastNameLabelWithInputComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> lastNameLabelWithInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person inputComponent labelComponent|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2000).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPerson lastNameSlotDefinition model: person.
	self assert: person lastName equals: 'Smith'.
	self assert: component componentName equals: 'lastNameLabelAndInput'.

	inputComponent := component inputComponent.
	self assert: inputComponent notNil.
	labelComponent := component labelComponent.
	self assert: labelComponent notNil.

	self assert: inputComponent componentName equals: 'lastName'.
	self assert: inputComponent valueAccessor slotName equals: 'lastName'.
	self assert: inputComponent displayValue equals: 'Smith'.
	self assert: inputComponent model equals: person.
	self assert: labelComponent componentName equals: 'lastNameLabel'.
	self assert: labelComponent text equals: 'Last Name'.
	self assert: labelComponent model equals: person.
	self assert: labelComponent for equals: 'lastName'.
	^ component
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> mainSkillsAsRadioGroupWithInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person inputComponent labelComponent|
	self ensureCurrentSystemIsPrototypeSystem.

	person := LxxPerson new.
	
	component := LuiLabelWithInputComponent 
			onSlot: (person slotDefinitionNamed: 'mainSkill') 
			model: person
			widgetClass: LuiRadioButtons
			inputComponentName: 'mainSkillRadio'.
	self assert: component componentName equals: 'mainSkillRadioLabelAndInput'.

	inputComponent := component inputComponent.
	self assert: inputComponent notNil.
	labelComponent := component labelComponent.
	self assert: labelComponent notNil.
	self assertRendered: component equals: self expectedMainSkillsAsRadioGroupHtml.
	^ component
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> properlyFormedComponent [
	<gtExample>
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx'.
	self assert: component hasNoComponents description: 'Label and Input are only created with the onSlot: method'.
	^ component
]
