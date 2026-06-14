Class {
	#name : 'LuiLabelWithInputComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiLabelWithInputComponentExamples >> expectedMainSkillsAsRadioGroupHtml [
	^'<div data-name="mainSkillRadioLabelAndInput" data-StClass="LuiLabelWithInputComponent"><label id="44892641" data-name="mainSkillLabel" data-StClass="LuiLabel" for="mainSkill">Main Skill</label><div id="6714643" data-name="mainSkillRadioButtons" data-StClass="LuiRadioButtons"><div id="2264579" data-name="unknown_RadioButtonAndLabel" data-StClass="LuiRadioButtonWithLabel"><input id="220995112" data-name="unknown_RadioButton" data-StClass="LuiRadioButton" name="mainSkill" value="unknown" type="radio"/><label id="57874248" data-name="unknown_RadioButtonLabel" data-StClass="LuiLabel"></label></div><div id="22809164" data-name="1_RadioButtonAndLabel" data-StClass="LuiRadioButtonWithLabel"><input id="37212082" data-name="1_RadioButton" data-StClass="LuiRadioButton" name="mainSkill" value="1" type="radio"/><label id="77981290" data-name="1_RadioButtonLabel" data-StClass="LuiLabel">Skill 1</label></div><div id="38215145" data-name="2_RadioButtonAndLabel" data-StClass="LuiRadioButtonWithLabel"><input id="33927364" data-name="2_RadioButton" data-StClass="LuiRadioButton" name="mainSkill" value="2" type="radio"/><label id="235682292" data-name="2_RadioButtonLabel" data-StClass="LuiLabel">Skill 2</label></div><div id="53621126" data-name="3_RadioButtonAndLabel" data-StClass="LuiRadioButtonWithLabel"><input id="30642646" data-name="3_RadioButton" data-StClass="LuiRadioButton" name="mainSkill" value="3" type="radio"/><label id="124947838" data-name="3_RadioButtonLabel" data-StClass="LuiLabel">Skill 3</label></div></div></div>'
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
	^'<div data-name="hasRedHairLabelAndInput" data-StClass="LuiLabelWithInputComponent"><label id="47040735" data-name="hasRedHairLabelAndInputLabel" data-StClass="LuiLabel"></label><div id="141918531" data-name="hasRedHairLabelAndInputInput" data-StClass="LuiCheckboxAndLabel"><input id="121675685" data-name="hasRedHair" data-StClass="LuiCheckbox" name="hasRedHair" type="checkbox"/><label id="223971761" data-name="hasRedHairLabel" data-StClass="LuiLabel" for="hasRedHair">Has Red Hair</label></div></div>'
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameInputComponent [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<input id="17819216" data-name="lastName" data-StClass="LuiTextInput" name="lastName" placeholder="Last Name" class="inputField" value="Smith" type="text"/>'.
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
	expectedHtml := '<div data-name="lastNameLabelAndInput" data-StClass="LuiLabelWithInputComponent"><label id="1052112" data-name="lastNameLabel" data-StClass="LuiLabel" for="lastName">Last Name</label><input id="17819216" data-name="lastName" data-StClass="LuiTextInput" name="lastName" placeholder="Last Name" class="inputField" value="Smith" type="text"/></div>'.
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
	self assert: labelComponent labelString equals: 'Last Name'.
	self assert: labelComponent model equals: person.
	self assert: labelComponent forName equals: 'lastName'.
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
			componentNamePrefix: 'mainSkillRadio'.
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
