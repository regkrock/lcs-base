Class {
	#name : #LcsVirtualSlotDefinition,
	#superclass : #LcsBaseSlot,
	#instVars : [
		'valueAccessBlock'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsVirtualSlotDefinition >> currentSlotVarIn: aDomainObject [

	^ self valueAccessBlock value: aDomainObject
]

{ #category : #configuration }
LcsVirtualSlotDefinition >> defaultValueAccessBlock [
	[ :domainObject | LcsError signal: 'defaultValueAccessBlock not overriden or not initialized']
]

{ #category : #initiailize }
LcsVirtualSlotDefinition >> initialize [
	super initialize.
	self valueAccessBlock: self defaultValueAccessBlock
]

{ #category : #'slot model' }
LcsVirtualSlotDefinition >> slotVarNamed: anObject in: aDomainObject [
	self error: 'This is a read only slot'
]

{ #category : #'slot model' }
LcsVirtualSlotDefinition >> slotVarPut: anObject in: aDomainObject [
	self error: 'This is a read only slot'
]

{ #category : #accessing }
LcsVirtualSlotDefinition >> valueAccessBlock [
	^ valueAccessBlock
]

{ #category : #accessing }
LcsVirtualSlotDefinition >> valueAccessBlock: anObject [
	valueAccessBlock := anObject
]

{ #category : #'slot model' }
LcsVirtualSlotDefinition >> valueAccessor: aSymbol [
	self valueAccessBlock: [ :domainObject | domainObject perform: aSymbol ]
]

{ #category : #'slot model' }
LcsVirtualSlotDefinition >> valueIn: aDomainObject [
	^ self valueAccessBlock value: aDomainObject
]
