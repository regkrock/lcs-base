Class {
	#name : 'LcsUpdateSiblingWithCollectionDefault',
	#superclass : 'LcsUpdateAction',
	#instVars : [
		'siblingSlotName',
		'sourceCollectionSlotName'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsUpdateSiblingWithCollectionDefault >> defaultActionBlock [
	^ [ :newValue :domainObject :oldValue | 
		domainObject
			perform: self siblingSlotSetter
			with: (newValue perform: self sourceCollectionSlotName asSymbol) defaultInstance ]
]

{ #category : 'accessing' }
LcsUpdateSiblingWithCollectionDefault >> siblingSlotName [
	^ siblingSlotName
]

{ #category : 'accessing' }
LcsUpdateSiblingWithCollectionDefault >> siblingSlotName: aSlotName [
	siblingSlotName := aSlotName
]

{ #category : 'defaults' }
LcsUpdateSiblingWithCollectionDefault >> siblingSlotSetter [
	^ (self siblingSlotName , ':') asSymbol
]

{ #category : 'accessing' }
LcsUpdateSiblingWithCollectionDefault >> sourceCollectionSlotName [
	^ sourceCollectionSlotName
]

{ #category : 'accessing' }
LcsUpdateSiblingWithCollectionDefault >> sourceCollectionSlotName: aSlotName [ 
	sourceCollectionSlotName := aSlotName
]
