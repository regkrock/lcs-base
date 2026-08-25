Class {
	#name : 'LcsSystemSupportModule',
	#superclass : 'LcsModule',
	#instVars : [
		'justifications'
	],
	#category : 'Lcs-SystemSupport-Core',
	#package : 'Lcs-SystemSupport',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsSystemSupportModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'configuration' }
LcsSystemSupportModule class >> defaultModuleName [
	^ 'SystemSupport'
]

{ #category : 'slot definitions' }
LcsSystemSupportModule class >> justificationsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsValueObjectsGlobalCollectionSlot new
		addSlotType: LcsJustifications;
		addCollectionMemberType: LcsJustification;
		slotName: 'justifications';
		loaderClass: LcsJustificationsLoader;
		yourself
]

{ #category : 'generated method' }
LcsSystemSupportModule class >> moduleConfigurationClass [
	^ LcsSystemSupportModuleConfiguration
]

{ #category : 'configuration' }
LcsSystemSupportModule class >> owningModules [
	<owningModule: 'LcsDemoSystem' priority: 0.5>
	<owningModule: 'LcsWarRabbitLibrary' priority: 0.5>
	<owningModule: 'LxxPrototypeSystem' priority: 0.5>
	<owningModule: 'LcsSailingClubSystem' priority: 0.5>
	<owningModule: 'LcsBasicSystem' priority: 0.5>
]

{ #category : 'accessing' }
LcsSystemSupportModule >> justifications [
	^ self slotVarNamed: 'justifications'
]

{ #category : 'as yet unclassified' }
LcsSystemSupportModule >> justifications: anObject [
	self slotVarNamed: 'justifications' put: anObject
]
