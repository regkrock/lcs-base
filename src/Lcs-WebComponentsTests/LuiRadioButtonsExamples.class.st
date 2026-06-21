Class {
	#name : 'LuiRadioButtonsExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiRadioButtonsExamples >> mainSkillsRadioGroup [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person callbackBlock|
	self ensureCurrentSystemIsPrototypeSystem.

	person := LxxPerson new.
	
	callbackBlock := [ :value | value ].
	component := (LuiRadioButtons 
			onSlotNamed: 'mainSkill' 
			model: person).
	self assert: component componentName equals: 'mainSkillRadioButtons'.
	self assert: component selected skillCode equals: 'unknown'.
	"self assert: component callbackBlock printString equals: callbackBlock printString."
	^ component
]
