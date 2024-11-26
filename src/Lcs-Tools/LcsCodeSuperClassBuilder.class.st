Class {
	#name : #LcsCodeSuperClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeSuperClassBuilder class >> targetSuperclassName [
	^ 'LcsCode'
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #'gt view' }
LcsCodeSuperClassBuilder >> jobStepDescription [
	^ 'Create class: ' , self newClassName asString , ' as subclass of ' , self targetSuperclassName displayString
]

{ #category : #'gt view' }
LcsCodeSuperClassBuilder >> stepDescription [
	^ 'Create class: ' , self newClassName asString , ' as subclass of ' , self targetSuperclassName displayString
]

{ #category : #accessing }
LcsCodeSuperClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName
]
