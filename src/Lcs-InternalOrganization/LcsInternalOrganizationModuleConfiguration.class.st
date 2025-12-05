Class {
	#name : 'LcsInternalOrganizationModuleConfiguration',
	#superclass : 'LcsBaseConfiguration',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'organization model' }
LcsInternalOrganizationModuleConfiguration >> internalOrganization [
	^ self parent internalOrganization
]
