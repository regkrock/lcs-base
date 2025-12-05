Class {
	#name : 'LcsUpdateSiblingWithNewInstanceOfSourceClass',
	#superclass : 'LcsUpdateSiblingFromSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsUpdateSiblingWithNewInstanceOfSourceClass >> defaultActionBlock [
	^ [ :newValue :parentDomainObject :oldValue | 
	parentDomainObject
		perform: self siblingSlotSetter
		with: (self sourceClassIn: newValue) new ]
]

{ #category : 'defaults' }
LcsUpdateSiblingWithNewInstanceOfSourceClass >> sourceClassIn: newValue [
	^ newValue perform: self sourceSlotName asSymbol
]
