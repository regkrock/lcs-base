Class {
	#name : 'LcsSecurityRolesLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'data' }
LcsSecurityRolesLoader >> data [
	^ 'admin
visitor
guest
student
member
boardMember'
]

{ #category : 'loading' }
LcsSecurityRolesLoader >> load [
	self loadFrom: self data readStream class: self targetClass schema: self schema
]

{ #category : 'loading' }
LcsSecurityRolesLoader >> loadFrom: aDataStream class: aTargetClass schema: anArray [
	| instance line setters | 
	setters := anArray collect: [ :each | (each , ':') asSymbol ].
	[ aDataStream atEnd ] whileFalse: [
		instance := aTargetClass new.
		line := aDataStream nextLine. 
		setters with: (line substrings: {Character tab}) do: [ :setter :value |
			instance perform: setter with: value ] ] 
]

{ #category : 'loading' }
LcsSecurityRolesLoader >> schema [
	^#( 'role' )
]

{ #category : 'configuration' }
LcsSecurityRolesLoader >> targetClass [
	^ LcsSecurityRole
]
