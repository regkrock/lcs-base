Class {
	#name : 'LcsDomainObjectSlotViewItem',
	#superclass : 'LcsViewItem',
	#instVars : [
		'domainObject'
	],
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsDomainObjectSlotViewItem class >> defaultChildrenSelector [
	^ #domainObjectAllAccessorSlotViewItems
]

{ #category : 'instance creation' }
LcsDomainObjectSlotViewItem class >> newLabel: aString item: anObject  domainObject: aDomainObject [
	^ self new
		initializeLabel: aString value: anObject  domainObject: aDomainObject;
		yourself
]

{ #category : 'accessing' }
LcsDomainObjectSlotViewItem >> domainObject [
	^ domainObject
]

{ #category : 'accessing' }
LcsDomainObjectSlotViewItem >> domainObject: anObject [
	domainObject := anObject
]

{ #category : 'initialize' }
LcsDomainObjectSlotViewItem >> initializeLabel: aString value: anObject domainObject: aDomainObject [
	self 
		label: aString;
		item: anObject;
		domainObject: aDomainObject
]

{ #category : 'children' }
LcsDomainObjectSlotViewItem >> itemChildrenForNonresponders [
	self item isString ifTrue: [ ^ #()].
	self item isCollection ifTrue: [ ^ self item collect: [ :each | LcsDomainObjectSlotViewItem newLabel: '' item: each ]].
	^ super itemChildrenForNonresponders
]

{ #category : 'printing' }
LcsDomainObjectSlotViewItem >> newValue [
	self domainObject isInAddingState ifTrue: [ ^ self item ].
	^ ((self currentUnitOfWork
		changedSlotRecordFor: self domainObject
		slotNamed: self label) ifNil: [ ^ '' ]) newValue
]

{ #category : 'printing' }
LcsDomainObjectSlotViewItem >> originalValue [
	self domainObject isNil ifTrue: [ ^ nil ].
	^ self domainObject isInAddingState ifTrue: [ nil ] ifFalse: [ self item ]
]
