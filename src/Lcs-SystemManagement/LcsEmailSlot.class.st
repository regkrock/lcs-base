Class {
	#name : 'LcsEmailSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsEmailSlot >> initialize [
	super initialize.
	self 
		slotName: 'email';
		required: true;
		addValidationRule: (
			LcsValidationRule new
				conditionBlock: [ :value :domainObject : oldValue | value notEmpty];
				description: 'email is required');
		beAllowInitialNull

]
