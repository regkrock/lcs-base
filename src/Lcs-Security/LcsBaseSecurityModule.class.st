Class {
	#name : 'LcsBaseSecurityModule',
	#superclass : 'LcsModule',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsBaseSecurityModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'configuration' }
LcsBaseSecurityModule class >> defaultModuleName [
	^ 'Security Module'
]

{ #category : 'configuration' }
LcsBaseSecurityModule class >> moduleConfigurationClass [
	^ LcsSecurityModuleConfiguration
]

{ #category : 'security' }
LcsBaseSecurityModule >> hasPermissionToAddToSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : 'security' }
LcsBaseSecurityModule >> hasPermissionToReadSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : 'security' }
LcsBaseSecurityModule >> hasPermissionToWriteSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : 'security' }
LcsBaseSecurityModule >> userWithUuid: aUserUuid [
	^ self users userWithUuid: aUserUuid
]
