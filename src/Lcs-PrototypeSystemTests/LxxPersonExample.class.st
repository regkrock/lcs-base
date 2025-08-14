Class {
	#name : #LxxPersonExample,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-PrototypeSystemTests-Examples'
}

{ #category : #examples }
LxxPersonExample >> johnFreeman [
	<gtExample>
	| person |
	self assert: self currentSystem isPrototypeSystem.
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
