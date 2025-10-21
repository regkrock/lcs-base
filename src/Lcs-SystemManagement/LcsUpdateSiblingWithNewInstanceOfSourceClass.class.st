Class {
	#name : #LcsUpdateSiblingWithNewInstanceOfSourceClass,
	#superclass : #LcsUpdateSiblingFromSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsUpdateSiblingWithNewInstanceOfSourceClass >> defaultActionBlock [
	^ [ :newValue :domainObject :oldValue | 
	domainObject
		perform: self siblingSlotSetter
		with: (self sourceClassIn: newValue) new ]
]

{ #category : #defaults }
LcsUpdateSiblingWithNewInstanceOfSourceClass >> sourceClassIn: newValue [
	^ newValue perform: self sourceSlotName asSymbol
]
