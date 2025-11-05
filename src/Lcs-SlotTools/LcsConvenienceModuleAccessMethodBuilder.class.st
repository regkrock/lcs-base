Class {
	#name : #LcsConvenienceModuleAccessMethodBuilder,
	#superclass : #LcsMethodBuilder,
	#instVars : [
		'owningModuleClass'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #initialize }
LcsConvenienceModuleAccessMethodBuilder >> initialize [
	super initialize.
	self categoryName: #configuration
]

{ #category : #command }
LcsConvenienceModuleAccessMethodBuilder >> methodSource [
	^'<1s>
	^ self moduleNamed: ''<2s> Module''' expandMacrosWith: self selector with: self targetClassName
]

{ #category : #accessing }
LcsConvenienceModuleAccessMethodBuilder >> owningModuleClass [
	^ owningModuleClass
]

{ #category : #accessing }
LcsConvenienceModuleAccessMethodBuilder >> owningModuleClass: anObject [
	owningModuleClass := anObject
]
