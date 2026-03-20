Class {
	#name : 'LxxPersonsExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

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
