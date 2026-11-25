Class {
	#name : 'LcsLoginProcessExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsLoginProcessExamples >> loginSuperuser [
	<gtExample>
	| process |
	self ensureCurrentSystemIsPrototypeSystem.
	(self currentSystem currentUser = self currentSystem guestuser)
		ifFalse: [ self currentSystem currentUser: self currentSystem guestuser ].
	process := LcsLoginProcess new.
	self assert: process email isEmpty.
	process email: 'superuser'.
	process password: 'R0binHood$'.
	process loginUser.
	self assert: self currentSystem currentUser equals: self currentSystem superuser
]
