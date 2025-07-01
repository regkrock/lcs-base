Class {
	#name : #LcsModuleNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsModuleNameSlot >> initialize [
	super initialize.
	self 
		slotName: 'moduleName';
		priority: 1;
		initialValueBlock: [ :module | module class defaultModuleName ]

		
]
