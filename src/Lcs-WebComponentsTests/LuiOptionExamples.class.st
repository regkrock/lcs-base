Class {
	#name : 'LuiOptionExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'examples' }
LuiOptionExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiOption named: 'xxx'.
	component optionValue: 'OptionValue'.
	component text: '123'.
	expectedHtml := '<option data-name="xxx" data-StClass="LuiOption" value="OptionValue" label="123"></option>'.
	"self 
		assertRendered: component
		equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiOptionExamples >> skill_1_Option [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person model expectedHtml|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	model := self currentSystem skills find: [ :each | each skillCode = '1' ].
	component := LuiOption onSlot: (LxxPerson slotDefinitionNamed: 'mainSkill') model: model.
	self assert: component model equals: model.
	expectedHtml := '<option data-name="option_1" data-StClass="LuiOption" value="1" label="Skill 1"></option>'.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiOptionExamples >> unknownSkillOption [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person model expectedHtml|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	model := self currentSystem skills unknownInstance.
	component := LuiOption onSlot: LxxPerson mainSkillSlotDefinition model: model.
	self assert: component model equals: model.
	expectedHtml := '<option data-name="option_unknown" data-StClass="LuiOption" value="unknown" label=""></option>'.
	"self assertRendered: component equals: expectedHtml."
	^ component
]
