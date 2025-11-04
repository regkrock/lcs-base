Class {
	#name : #LcsGlobalCollectionPatternFormExamples,
	#superclass : #LcsMultislotPatternFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> addFoosGlobalCollectionWithPersonHavingAFooInstanceForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	self ensureCurrentsystemIsPrototypeSystem.
	form := self slotCreationFormWithPrefixAndRootNameEntered.
	form slotModelBuilder targetDomainClasses: (OrderedCollection with: LxxPerson).
	form slotModelBuilder
		umlPositions: self addFoosGlobalCollectionWithPµersonHavingAFooInstanceFormUmlPositions.
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> addFoosGlobalCollectionWithPµersonHavingAFooInstanceFormUmlPositions [
	^ {495.21256086561414 @ 552.6243828667534.
		433.319557401869 @ 690.2222222222222.
		563.1155588361952 @ 621.2222222222222.
		597.0255567762587 @ 690.8200615776909.
		747.3495561811659 @ 557.6243828667534.
		754.462551328871 @ 621.2222222222222.
		844.4565603468153 @ 693.4179009331597.
		831.5555555555555 @ 800.0157402886284.
		285.4045526716444 @ 687.6243828667534.
		470.2645261653325 @ 582.2222222222222.
		570.4378442520083 @ 582.2222222222222.
		628.1346521742962 @ 650.8200615776909.
		805.401247932144 @ 587.2222222222222.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 683.3321659321605.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		487.11555883619525 @ 705.1174334173945.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		657.4095594618055 @ 669.3412465693366.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		908.637990575834 @ 723.0157402886284.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		657.4095594618055 @ 705.895157203695.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058.
		357.8765527937147 @ 688.721148889058}
]

{ #category : #configuration }
LcsGlobalCollectionPatternFormExamples >> formClass [
	^ LcsGlobalCollectionPatternForm
]

{ #category : #'examples - scripter' }
LcsGlobalCollectionPatternFormExamples >> formScripterWithRootNameEntered [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	^ super formScripterWithRootNameEntered
]

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> mainForm [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := super mainForm.
	self
		assert: form slotModelBuilder collectionSlotInstallationTargetClass
		equals: self targetClass.
	^ form
]

{ #category : #'examples - scripter' }
LcsGlobalCollectionPatternFormExamples >> mainFormScripter [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| scripter |
	scripter := super mainFormScripter.
	^ scripter
]

{ #category : #'examples - form' }
LcsGlobalCollectionPatternFormExamples >> slotCreationFormWithPrefixAndRootNameEntered [
	<gtExample>
	<return: #LcsGlobalCollectionPatternForm>
	| form |
	form := self slotCreationFormWithPrefixEntered.
	form slotModelBuilder createForRootName: 'Foo'.
	self assert: form slotModelBuilder jobSteps isEmpty.
	^form
]

{ #category : #configuration }
LcsGlobalCollectionPatternFormExamples >> targetClass [
	^ LxxPrototypeSystem
]
