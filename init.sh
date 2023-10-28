if [ ! -f package.json ]; then
  npx create-next-app nextjs-setup --use-yarn
  mv nextjs-setup/{.,}* .
  rmdir nextjs-setup
else
  yarn
fi