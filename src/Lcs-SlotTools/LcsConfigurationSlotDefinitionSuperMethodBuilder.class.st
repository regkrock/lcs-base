Class {
	#name : #LcsConfigurationSlotDefinitionSuperMethodBuilder,
	#superclass : #LcsMethodBuilder,
	#instVars : [
		'owningModuleClass',
		'moduleName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #initialize }
LcsConfigurationSlotDefinitionSuperMethodBuilder >> initialize [
	super initialize.
	self categoryName: #'slot definitions';
	beClassMethod
]

{ #category : #command }
LcsConfigurationSlotDefinitionSuperMethodBuilder >> methodSource [
	^ self selector , '
	<slotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass'
]
