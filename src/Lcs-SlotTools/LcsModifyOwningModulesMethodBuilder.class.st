Class {
	#name : 'LcsModifyOwningModulesMethodBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'owningModuleClass',
		'priority',
		'owningModuleClassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'initialize' }
LcsModifyOwningModulesMethodBuilder >> initialize [
	super initialize.
	self priority: 1.
	self selector: #owningModules.
	self categoryName: #configuration;
	beClassMethod
]

{ #category : 'command' }
LcsModifyOwningModulesMethodBuilder >> methodSource [
	| stream currentSource|
	stream := WriteStream on: String new.
	currentSource := (self targetClass class methodNamed: #owningModules) sourceCode.
	stream nextPutAll: currentSource.
	(currentSource findString: self owningModuleClassName startingAt: 1) = 0 ifTrue: [
		stream
			cr;
			tab;
			nextPutAll: '<owningModule: ' , self owningModuleClassName printString , ' priority: ' , self priority asString , '>'].
	^stream contents
]

{ #category : 'accessing' }
LcsModifyOwningModulesMethodBuilder >> owningModuleClass [
	^ owningModuleClass ifNil: [ owningModuleClass := self owningModuleClassName asClass ]
]

{ #category : 'accessing' }
LcsModifyOwningModulesMethodBuilder >> owningModuleClass: anObject [
	owningModuleClass := anObject
]

{ #category : 'accessing' }
LcsModifyOwningModulesMethodBuilder >> owningModuleClassName [
	^ owningModuleClassName
]

{ #category : 'accessing' }
LcsModifyOwningModulesMethodBuilder >> owningModuleClassName: anObject [
	owningModuleClassName := anObject
]

{ #category : 'printing' }
LcsModifyOwningModulesMethodBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Update #';
		nextPutAll: self selector asString;
		nextPutAll: ' in ';
		nextPutAll: self targetClassName displayString.
	self isClassMethod ifTrue: [
		aStream 
			nextPutAll: ' class']
]

{ #category : 'accessing' }
LcsModifyOwningModulesMethodBuilder >> priority [
	^ priority
]

{ #category : 'accessing' }
LcsModifyOwningModulesMethodBuilder >> priority: aNumber [
	priority := aNumber
]
