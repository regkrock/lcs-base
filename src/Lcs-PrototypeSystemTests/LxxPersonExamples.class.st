Class {
	#name : 'LxxPersonExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LxxPersonExamples >> johnFreeman [
	<gtExample>
	| person |
	person := self newPerson
				firstName: 'John';
				middleName: 'Edgar';
				lastName: 'Freeman'.
	self assert: person firstName equals: 'John'.
	self assert: person lastName equals: 'Freeman'.
	self assert: person middleName equals: 'Edgar'.
	^ person
]

{ #category : 'examples' }
LxxPersonExamples >> newPerson [
	<gtExample>
	| person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	^ person
]

{ #category : 'tests' }
LxxPersonExamples >> slotDefintiionViewItems [
	<gtExample>
	| allSlotDefinitionViewItems|
	self ensureCurrentSystemIsPrototypeSystem.
	allSlotDefinitionViewItems := LxxPerson slotDefinitionViewItems.
	self assert: allSlotDefinitionViewItems notEmpty.
	^ allSlotDefinitionViewItems
]
