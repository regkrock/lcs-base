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
LcsSecurityRolesLoader >> loadFrom: aDataStream class: aTargetClass into: aTargetCollection [
	| newDomainObject | 
	[ aDataStream atEnd ] whileFalse: [
		newDomainObject := aTargetClass new.
		self populate: newDomainObject with: aDataStream nextLine.
		aTargetCollection add: newDomainObject ] 
]

{ #category : 'loading' }
LcsSecurityRolesLoader >> loadInto: aTargetCollection [
	self
		loadFrom: self data readStream
		class: self targetClass
		into: aTargetCollection
]

{ #category : 'schema' }
LcsSecurityRolesLoader >> schema [
	^#( 'role' )
]

{ #category : 'configuration' }
LcsSecurityRolesLoader >> targetClass [
	^ LcsSecurityRole
]
