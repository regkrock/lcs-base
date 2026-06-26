Class {
	#name : 'LuiLabelWithInputComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiLabelWithInputComponentExamples >> expectedMainSkillsAsRadioGroupHtml [
	^'<div data-name="mainSkillRadioLabelAndInput" data-StClass="LuiLabelWithInputComponent" class="labelAndInputRow"><label id="61110836" data-name="mainSkillRadioLabel" data-StClass="LuiLabel" for="236842500">Main Skill</label><div id="236842500" data-name="mainSkillRadio" data-StClass="LuiRadioButtons" class="radioButtons"><input name="1" id="236842500_1" checked value="1" type="radio"/><label id="236842500_1_Label" for="236842500_1"></label><input name="1" id="236842500_2" value="2" type="radio"/><label id="236842500_2_Label" for="236842500_2">Skill 1</label><input name="1" id="236842500_3" value="3" type="radio"/><label id="236842500_3_Label" for="236842500_3">Skill 2</label><input name="1" id="236842500_4" value="4" type="radio"/><label id="236842500_4_Label" for="236842500_4">Skill 3</label></div></div>'
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
			equals: 'hasRedHairLabel'.
	self assert: component inputComponentName
			equals: 'hasRedHair'.

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
	^'<div data-name="hasRedHairLabelAndInput" data-StClass="LuiLabelWithInputComponent" class="labelAndInputRow"><label id="23086076" data-name="hasRedHairLabel" data-StClass="LuiLabel" for="95789676"></label><div id="95789676" data-name="hasRedHair" data-StClass="LuiCheckboxAndLabel" class="radioButtonAndLabel"><input id="47342114" data-name="hasRedHair" data-StClass="LuiCheckbox" name="1" type="checkbox"/><input name="2" type="hidden"/><label id="155752730" data-name="hasRedHairLabel" data-StClass="LuiLabel" for="47342114">Has Red Hair</label></div></div>'
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
	| labelAndInputComponent |
	labelAndInputComponent := self lastNameLabelWithInputComponent.
	^ self
		assertRendered: labelAndInputComponent labelComponent
		equals: '<label id="1052112" data-name="lastNameLabel" data-StClass="LuiLabel" for="', labelAndInputComponent inputComponent componentId ,'">Last Name</label>'
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameWithInLabelAndInputComponent [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<div data-name="lastNameLabelAndInput" data-StClass="LuiLabelWithInputComponent" class="labelAndInputRow"><label id="1052112" data-name="lastNameLabel" data-StClass="LuiLabel" for="17819216">Last Name</label><input id="17819216" data-name="lastName" data-StClass="LuiTextInput" placeholder="Last Name" class="inputField" name="1" value="Smith" type="text"/></div>'.
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
	self assert: labelComponent for equals: inputComponent componentId.
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
