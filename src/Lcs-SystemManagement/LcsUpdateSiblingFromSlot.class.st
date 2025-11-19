Class {
	#name : 'LcsUpdateSiblingFromSlot',
	#superclass : 'LcsUpdateAction',
	#instVars : [
		'siblingSlotName',
		'sourceSlotName'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsUpdateSiblingFromSlot >> defaultActionBlock [
	^ [ :newValue :domainObject :oldValue | 
		domainObject
			perform: self siblingSlotSetter
			with: (newValue perform: self sourceSlotName asSymbol) ]
]

{ #category : 'accessing' }
LcsUpdateSiblingFromSlot >> siblingSlotName [
	^ siblingSlotName
]

{ #category : 'accessing' }
LcsUpdateSiblingFromSlot >> siblingSlotName: aSlotName [
	siblingSlotName := aSlotName
]

{ #category : 'defaults' }
LcsUpdateSiblingFromSlot >> siblingSlotSetter [
	^ (self siblingSlotName , ':') asSymbol
]

{ #category : 'accessing' }
LcsUpdateSiblingFromSlot >> sourceSlotName [
	^ sourceSlotName
]

{ #category : 'accessing' }
LcsUpdateSiblingFromSlot >> sourceSlotName: aString [
	sourceSlotName := aString
]
