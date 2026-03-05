Class {
	#name : 'LcsMemberOfLocalCollectionSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> localMemberSlotBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder
		targetClassName: 'LxxInvoice';
		slotName: 'parent';
		collectionSlotName: 'invoiceItems';
		"collectionClassName: #LxxInvoiceItem;"
		addSlotType: 'LxxInvoiceItems'.
	builder buildJobSteps.
	^ builder
]

{ #category : 'tests' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> memberOfLocalCollectionSlotAddedToConnectInvoiceItemWithInvoiceItemsInInvoice [
	<gtExample>
	<TODO: 'The commented out assertion fails. The cause is that LcsMemberOfSlotDefinition is not properly wired for a local member of situation. Especially for initialization.'>
	| invoiceBuilderJob invoiceItemBuilderJob builder |
	invoiceBuilderJob := LcsDomainClassAndGlobalCollectionClassBuilderJobExamples new 
							invoiceAndInvoicesBuilderJob.
	invoiceItemBuilderJob := LcsDomainClassAndLocalCollectionClassBuilderJobExamples new
							 	invoiceItemAndLocalInvoiceItemsCreationJob.
	builder := self localMemberSlotBuilder.
	[
		invoiceBuilderJob execute.
		invoiceBuilderJob verifyCodeInstallation.
		invoiceItemBuilderJob execute.
		invoiceItemBuilderJob verifyCodeInstallation.
		self assert: ('LxxInvoice' asClass canUnderstand: #invoiceItems) not.
		builder execute.
		builder verifyCodeInstallation.
		"self verifyInvoiceItemCreation" ]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			invoiceItemBuilderJob uninstall.
			invoiceItemBuilderJob verifyUninstall.
			invoiceBuilderJob uninstall.
			invoiceBuilderJob verifyUninstall ]
]

{ #category : 'examples' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsMemberOfLocalCollectionSlotBuilder new.
	^ builder
]

{ #category : 'validation' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> verifyInvoiceItemCreation [
		| invoice invoiceItem |
		self assert: ('LxxInvoice' asClass canUnderstand: #invoiceItems).
		self assert: (invoice := 'LxxInvoice' asClass new invoiceItems isEmpty ).
		invoiceItem := #LxxInvoiceItem asClass new
]
