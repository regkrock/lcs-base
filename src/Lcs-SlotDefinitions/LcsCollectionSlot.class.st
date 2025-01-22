Class {
	#name : #LcsCollectionSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #default }
LcsCollectionSlot >> defaultInitialValueBlaock [
	^ [ self typeClass new ]
]

{ #category : #iniitialize }
LcsCollectionSlot >> initialize [
	super initialize.
	self slotName: 'collection'
]
