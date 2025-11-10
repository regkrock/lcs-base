Class {
	#name : #LxxPersonExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #examples }
LxxPersonExamples >> johnFreeman [
	<gtExample>
	| person |
	self ensureCurrentSystemIsPrototypeSystem.
	self assert: (self currentSystem ifNil: [ false ] ifNotNil: [:system | system isPrototypeSystem ]).
	person := LxxPerson new.
	person
			firstName: 'John';
			middleName: 'Edgar';
			lastName: 'Freeman'.
	self assert: person firstName equals: 'John'.
	self assert: person lastName equals: 'Freeman'.
	self assert: person middleName equals: 'Edgar'.
	^ person
]

{ #category : #tests }
LxxPersonExamples >> slotDefintionViewItems [
	<gtExample>
	| allSlotDefinitionViewItems|
	self ensureCurrentSystemIsPrototypeSystem.
	allSlotDefinitionViewItems := LxxPerson slotDefinitionViewItems.
	self assert: allSlotDefinitionViewItems notEmpty.
	^ allSlotDefinitionViewItems
]
