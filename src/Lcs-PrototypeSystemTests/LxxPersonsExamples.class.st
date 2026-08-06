Class {
	#name : 'LxxPersonsExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LxxPersonsExamples >> findPersonNamed: aString [ 
	^ self currentSystem persons find: [ :each | each fullName = aString ]
]

{ #category : 'examples' }
LxxPersonsExamples >> freemanClan [
	<gtExample>
	self ensureCurrentSystemIsPrototypeSystem.
	(self findPersonNamed: 'John Freeman') 
		ifNil: [ LxxPersonExamples new johnFreeman ].
	(self findPersonNamed: 'Jessee Freeman') 
		ifNil: [ LxxPersonExamples new jesseeFreeman ].
	(self findPersonNamed: 'Mildred Freeman') 
		ifNil: [ LxxPersonExamples new mildredFreeman ].
	(self findPersonNamed: 'Ethel Freeman') 
		ifNil: [ LxxPersonExamples new ethelFreeman ].
	(self findPersonNamed: 'Pauline Freeman') 
		ifNil: [ LxxPersonExamples new paulineFreeman ].
	(self findPersonNamed: 'Margaret Freeman') 
		ifNil: [ LxxPersonExamples new margaretFreeman ].
	"self assert: self currentSystem persons pendingAdds size >= 6."
	^ self currentSystem persons
]

{ #category : 'examples' }
LxxPersonsExamples >> newPersonsCollection [
	<gtExample>
	<after: #clearUnitOfWork>
	| persons |
	self ensureCurrentSystemIsPrototypeSystem.
	persons := LxxPersons new.
	self assert: self currentSystem persons caption equals: 'Persons'.
	^ persons
]

{ #category : 'examples' }
LxxPersonsExamples >> personsWithNewPersonInPendingAdds [
	<gtExample>
	<after: #clearUnitOfWork>
	| person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new newPerson.
	self assert: (self currentSystem persons pendingAdds includes: person).
	self assert: self currentSystem persons caption equals: 'Persons'.
	self deny: (self currentSystem persons collection includes: person).
	^ self currentSystem persons
]
