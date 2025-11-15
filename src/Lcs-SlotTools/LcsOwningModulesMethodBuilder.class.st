Class {
	#name : #LcsOwningModulesMethodBuilder,
	#superclass : #LcsMethodBuilder,
	#instVars : [
		'owningModuleClass',
		'priority'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #initialize }
LcsOwningModulesMethodBuilder >> initialize [
	super initialize.
	self priority: 5.	"Security module is 1. It needs to be loaded first"
	self selector: #owningModules.
	self categoryName: #configuration;
	beClassMethod
]

{ #category : #command }
LcsOwningModulesMethodBuilder >> methodSource [
	^'owningModules
	<owningModule: ' , self owningModuleClass name asString printString , ' priority: ' , self priority asString , '>' 
]

{ #category : #accessing }
LcsOwningModulesMethodBuilder >> owningModuleClass [
	^ owningModuleClass
]

{ #category : #accessing }
LcsOwningModulesMethodBuilder >> owningModuleClass: anObject [
	owningModuleClass := anObject
]

{ #category : #accessing }
LcsOwningModulesMethodBuilder >> priority [
	^ priority
]

{ #category : #accessing }
LcsOwningModulesMethodBuilder >> priority: aNumber [
	priority := aNumber
]
