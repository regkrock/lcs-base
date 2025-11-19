Class {
	#name : 'LcsModuleNameSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsModuleNameSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultModuleName ]
]

{ #category : 'initialize' }
LcsModuleNameSlot >> initialize [
	super initialize.
	self
		slotName: 'moduleName';
		priority: 1
]
