const { chatCompletion, getModels } = require('../services/openRouter');

async function test() {
  console.log('🐰 Starting OpenRouter Connectivity Test...\n');

  // 1. Test Model List (Optional)
  // console.log('📋 Fetching available models...');
  // const models = await getModels();
  // console.log(`✅ Found ${models.length} models.`);

  // 2. Test Chat Completion
  const testModel = 'openai/gpt-3.5-turbo'; // 免费或低成本模型用于测试
  console.log(`💬 Sending test message to ${testModel}...`);
  
  try {
    const response = await chatCompletion(
      testModel,
      [{ role: 'user', content: 'Hello from BunnyEra! Respond with a bunny emoji.' }]
    );
    
    console.log('\n🎉 Success! Response received:');
    console.log('------------------------------------------------');
    console.log(response.content);
    console.log('------------------------------------------------\n');
  } catch (error) {
    console.error('\n❌ Test Failed. Please check your OPENROUTER_API_KEY in .env file.');
  }
}

test();
