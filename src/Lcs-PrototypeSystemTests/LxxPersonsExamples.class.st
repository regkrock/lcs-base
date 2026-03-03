Class {
	#name : 'LxxPersonsExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LxxPersonsExamples >> personsWithNewPersonApplied [
	<gtExample>
	| persons person |
	persons := self personsWithNewPersonInPendingAdds.
	person := persons pendingAdds last.
	self currentSystem applyChanges.

	self assert: (self currentSystem persons pendingAdds isEmpty).
	self assert: (self currentSystem persons includes: person).
	self assert: person parent == self currentSystem persons.
	self currentSystem currentUnitOfWork hasNoChanges.
	^ persons
]

{ #category : 'examples' }
LxxPersonsExamples >> personsWithNewPersonInPendingAdds [
	<gtExample>
	| person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new newPerson.
	self assert: (self currentSystem persons pendingAdds includes: person).
	self deny: (self currentSystem persons collection includes: person).
	^ self currentSystem persons
]
