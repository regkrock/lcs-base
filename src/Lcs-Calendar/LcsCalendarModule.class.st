Class {
	#name : 'LcsCalendarModule',
	#superclass : 'LcsModule',
	#instVars : [
		'calendarEvents'
	],
	#category : 'Lcs-Calendar-Core',
	#package : 'Lcs-Calendar',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsCalendarModule class >> calendarEventsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionSlot new
			addSlotType: LcsCalendarEvents;
			addCollectionMemberType: LcsCalendarEvent;
			slotName: 'calendarEvents';
			yourself
]

{ #category : 'slot definitions' }
LcsCalendarModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'configuration' }
LcsCalendarModule class >> defaultModuleName [
	^ 'Calendar Module'
]

{ #category : 'generated method' }
LcsCalendarModule class >> moduleConfigurationClass [
	^ LcsCalendarModuleConfiguration
]

{ #category : 'configuration' }
LcsCalendarModule class >> owningModules [
	<owningModule: 'LcsSailingClubSystem' priority: 15>
	<owningModule: 'LcsDemoSystem' priority: 15>
]

{ #category : 'accessing' }
LcsCalendarModule >> calendarEvents [
	^ self slotVarNamed: 'calendarEvents'
]

{ #category : 'accessing' }
LcsCalendarModule >> calendarEvents: anObject [
	self slotVarNamed: 'calendarEvents' put: anObject
]
