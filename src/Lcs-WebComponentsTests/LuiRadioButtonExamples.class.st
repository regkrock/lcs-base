Class {
	#name : 'LuiRadioButtonExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiRadioButtonExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiRadioButton named: 'xxxx'.
	component name: 'radioGroup'.
	component optionValue: 'abc'.
	expectedHtml := '<input data-name="xxxx" data-StClass="LuiRadioButton" name="radioGroup" value="abc" type="radio"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiRadioButtonExamples >> skill_1_Option [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person model expectedHtml|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	model := self currentSystem skills find: [ :each | each skillCode = '1' ].
	
	component := LuiRadioButton onSlot: LxxPerson mainSkillSlotDefinition model: model.
	self assert: component model equals: model.
	
	expectedHtml := '<input data-name="radio_1" data-StClass="LuiRadioButton" name="mainSkill" value="1" type="radio"/>'.
	self assertRendered: component equals: expectedHtml.
	
	^ component
]
