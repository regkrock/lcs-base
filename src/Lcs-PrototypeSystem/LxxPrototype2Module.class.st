Class {
	#name : #LxxPrototype2Module,
	#superclass : #LcsModule,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxPrototype2Module class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsBaseConfiguration
]

{ #category : #accessing }
LxxPrototype2Module class >> moduleName [
	^ 'Prototype 2 Module'
]
