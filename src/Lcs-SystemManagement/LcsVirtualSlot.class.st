Class {
	#name : #LcsVirtualSlot,
	#superclass : #LcsBaseSlot,
	#instVars : [
		'valueAccessBlock'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #testing }
LcsVirtualSlot class >> isVirtualSlot [
	^ true
]

{ #category : #convenience }
LcsVirtualSlot class >> slotKind [
	^ 'virtual'
]

{ #category : #converting }
LcsVirtualSlot >> asViewItem [
	^ LcsVirtualSlotDefinitionViewItem on: self 
]

{ #category : #'slot model' }
LcsVirtualSlot >> currentSlotVarIn: aDomainObject [

	^ self valueAccessBlock value: aDomainObject
]

{ #category : #defaults }
LcsVirtualSlot >> defaultValueAccessBlock [
	[ :domainObject | LcsError signal: 'defaultValueAccessBlock not overriden or not initialized']
]

{ #category : #initialize }
LcsVirtualSlot >> initialize [
	super initialize.
	self valueAccessBlock: self defaultValueAccessBlock
]

{ #category : #'slot model' }
LcsVirtualSlot >> slotVarNamed: anObject in: aDomainObject [
	self error: 'This is a read only slot'
]

{ #category : #'slot model' }
LcsVirtualSlot >> slotVarPut: anObject in: aDomainObject [
	self deprecated: 'Need to pass the old value as well'.
	self error: 'This is a read only slot'
]

{ #category : #accessing }
LcsVirtualSlot >> valueAccessBlock [
	^ valueAccessBlock
]

{ #category : #accessing }
LcsVirtualSlot >> valueAccessBlock: anObject [
	valueAccessBlock := anObject
]

{ #category : #'slot model' }
LcsVirtualSlot >> valueAccessor: aSelector [
	self valueAccessBlock: [ :domainObject | domainObject perform: aSelector asSymbol]
]

{ #category : #'slot model' }
LcsVirtualSlot >> valueIn: aDomainObject [
	^ self valueAccessBlock value: aDomainObject
]
