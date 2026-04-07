Class {
	#name : 'LcsUserIdSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsUserIdSlot >> initialize [
	super initialize.
	self 
		slotName: 'userId';
		required: true;
		beAllowInitialNull;
		addValidationRule: (
			LcsValidationRule new
				conditionBlock: [ :value :domainObject : oldValue | value notEmpty];
				description: 'userId is required')
]
